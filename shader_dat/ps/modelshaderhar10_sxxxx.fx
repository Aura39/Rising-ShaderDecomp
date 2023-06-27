sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float aniso_diff_rate;
float aniso_shine;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float hll_rate;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;
float4 specularParam;
sampler specularmap_sampler;

struct PS_IN
{
	float color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float3 r4;
	float3 r5;
	float3 r6;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r0);
	r0 = tex2D(specularmap_sampler, r0);
	r2 = r1.w + -0.8;
	clip(r2);
	r2.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r2.xyz, r2.xyz);
	r0.w = 1 / sqrt(r0.w);
	r2.xyz = r0.www * r2.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r1.w = dot(r2.xyz, i.texcoord3.xyz);
	r2.x = r1.w * 0.5 + 0.5;
	r2.x = r2.x * r2.x;
	r3.x = lerp(r2.x, r1.w, hll_rate.x);
	r2.xyz = r3.xxx * point_light1.xyz;
	r2.xyz = r0.www * r2.xyz;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r3.xyz, r3.xyz);
	r0.w = 1 / sqrt(r0.w);
	r3.xyz = r0.www * r3.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r1.w = dot(r3.xyz, i.texcoord3.xyz);
	r2.w = r1.w * 0.5 + 0.5;
	r2.w = r2.w * r2.w;
	r3.x = lerp(r2.w, r1.w, hll_rate.x);
	r3.xyz = r3.xxx * muzzle_light.xyz;
	r2.xyz = r3.xyz * r0.www + r2.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xy = r0.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(Shadow_Tex_sampler, r3);
	r0.w = r3.z + g_ShadowUse.x;
	r3.xyz = i.texcoord1.xyz;
	r3.y = dot(r3.xyz, -i.texcoord3.xyz);
	r3.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r3.yz = r0.ww * r3.xy;
	r3.yz = r3.yz * -0.5 + 1;
	r4.xy = r3.yz * r3.yz;
	r4.xy = r4.xy * r4.xy;
	r3.yz = r3.yz * -r4.xy + 1;
	r1.w = r3.z * r3.y;
	r2.w = r1.w * 0.193754 + 0.5;
	r1.w = r1.w * 0.387508;
	r2.w = r2.w * r2.w + -r1.w;
	r1.w = hll_rate.x * r2.w + r1.w;
	r4.xyz = light_Color.xyz;
	r3.yzw = r4.xyz * aniso_diff_rate.xxx;
	r2.xyz = r3.yzw * r1.www + r2.xyz;
	r3.yz = -r1.yy + r1.xz;
	r1.w = max(abs(r3.y), abs(r3.z));
	r1.w = r1.w + -0.015625;
	r2.w = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.w;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r1.xz = (r1.ww >= 0) ? r1.yy : r1.xz;
	r2.xyz = r2.xyz * r1.xyz;
	r3.yzw = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r2.xyz = r3.yzw * ambient_rate_rate.xyz + r2.xyz;
	r1.w = (-r3.x >= 0) ? 0 : 1;
	r2.w = r3.x * r1.w;
	r3.xyz = r2.www * light_Color.xyz;
	r4.xyz = i.texcoord3.xyz;
	r5.xyz = r4.yzx * i.texcoord2.zxy;
	r4.xyz = i.texcoord2.yzx * r4.zxy + -r5.xyz;
	r5.xyz = lightpos.xyz + -i.texcoord1.xyz;
	r6.xyz = normalize(r5.xyz);
	r2.w = dot(r6.xyz, r4.xyz);
	r4.y = 1;
	r2.w = abs(r2.w) * -aniso_shine.x + r4.y;
	r3.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r3.w = 1 / sqrt(r3.w);
	r4.xyz = -i.texcoord1.xyz * r3.www + lightpos.xyz;
	r5.xyz = normalize(r4.xyz);
	r3.w = dot(r5.xyz, i.texcoord3.xyz);
	r2.w = r2.w * r3.w;
	r1.w = (-r2.w >= 0) ? 0 : r1.w;
	r3.w = pow(r2.w, specularParam.z);
	r1.w = r1.w * r3.w;
	r3.xyz = r1.www * r3.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r0.xyz = r0.www * r0.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = r1.xyz * r0.xyz;
	r0.xyz = r0.xyz * i.color.xxx + r2.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}