sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
sampler Spec_Pow_sampler;
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
sampler normalmap_sampler;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;
float4 specularParam;
sampler specularmap_sampler;
float4 tile;

struct PS_IN
{
	float color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
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
	float4 r4;
	float3 r5;
	float4 r6;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r0);
	r0 = tex2D(specularmap_sampler, r0);
	r2.x = -0.01;
	r2 = r1.w * ambient_rate.w + r2.x;
	clip(r2);
	r2.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r2.xyz, r2.xyz);
	r0.w = 1 / sqrt(r0.w);
	r2.xyz = r0.www * r2.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r3.xyz = i.texcoord3.xyz;
	r4.xyz = r3.yzx * i.texcoord2.zxy;
	r3.xyz = i.texcoord2.yzx * r3.zxy + -r4.xyz;
	r4.xy = g_All_Offset.xy;
	r4.xy = i.texcoord.xy * tile.xy + r4.xy;
	r4 = tex2D(normalmap_sampler, r4);
	r4.xyz = r4.xyz + -0.5;
	r5.xyz = r3.xyz * -r4.yyy;
	r2.w = r4.x * i.texcoord2.w;
	r4.xyw = r2.www * i.texcoord2.xyz + r5.xyz;
	r4.xyz = r4.zzz * i.texcoord3.xyz + r4.xyw;
	r5.xyz = normalize(r4.xyz);
	r2.x = dot(r2.xyz, r5.xyz);
	r2.y = r2.x * 0.5 + 0.5;
	r2.y = r2.y * r2.y;
	r3.w = lerp(r2.y, r2.x, hll_rate.x);
	r2.xyz = r3.www * point_light1.xyz;
	r2.xyz = r0.www * r2.xyz;
	r4.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r4.xyz, r4.xyz);
	r0.w = 1 / sqrt(r0.w);
	r4.xyz = r0.www * r4.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r2.w = dot(r4.xyz, r5.xyz);
	r3.w = r2.w * 0.5 + 0.5;
	r3.w = r3.w * r3.w;
	r4.x = lerp(r3.w, r2.w, hll_rate.x);
	r4.xyz = r4.xxx * muzzle_light.xyz;
	r2.xyz = r4.xyz * r0.www + r2.xyz;
	r4.y = dot(i.texcoord1.xyz, -r5.xyz);
	r0.w = 1 / i.texcoord7.w;
	r4.zw = r0.ww * i.texcoord7.xy;
	r4.zw = r4.zw * float2(-0.5, 0.5) + 0.5;
	r4.zw = r4.zw + g_TargetUvParam.xy;
	r6 = tex2D(Shadow_Tex_sampler, r4.zwzw);
	r0.w = r6.z + g_ShadowUse.x;
	r2.w = dot(lightpos.xyz, r5.xyz);
	r4.x = r2.w;
	r4.xy = r0.ww * r4.xy;
	r4.xy = r4.xy * -0.5 + 1;
	r4.zw = r4.xy * r4.xy;
	r4.zw = r4.zw * r4.zw;
	r4.xy = r4.xy * -r4.zw + 1;
	r3.w = r4.y * r4.x;
	r4.x = r3.w * 0.193754 + 0.5;
	r3.w = r3.w * 0.387508;
	r4.x = r4.x * r4.x + -r3.w;
	r3.w = hll_rate.x * r4.x + r3.w;
	r4.xyz = light_Color.xyz;
	r4.xyz = r4.xyz * aniso_diff_rate.xxx;
	r2.xyz = r4.xyz * r3.www + r2.xyz;
	r4.xy = -r1.yy + r1.xz;
	r3.w = max(abs(r4.x), abs(r4.y));
	r3.w = r3.w + -0.015625;
	r4.x = (-r3.w >= 0) ? 0 : 1;
	r3.w = (r3.w >= 0) ? -0 : -1;
	r3.w = r3.w + r4.x;
	r3.w = (r3.w >= 0) ? -r3.w : -0;
	r1.xz = (r3.ww >= 0) ? r1.yy : r1.xz;
	r1.w = r1.w * ambient_rate.w;
	r1.w = r1.w * prefogcolor_enhance.w;
	o.w = r1.w;
	r2.xyz = r2.xyz * r1.xyz;
	r4.xyz = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r4.xyz = r4.xyz * ambient_rate_rate.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = -r1.w + r2.w;
	r1.w = r1.w + 1;
	r2.xyz = r4.xyz * r1.www + r2.xyz;
	r4.xyz = lightpos.xyz + -i.texcoord1.xyz;
	r6.xyz = normalize(r4.xyz);
	r1.w = dot(r6.xyz, r3.xyz);
	r3.y = 1;
	r1.w = abs(r1.w) * -aniso_shine.x + r3.y;
	r2.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r2.w = 1 / sqrt(r2.w);
	r3.xyz = -i.texcoord1.xyz * r2.www + lightpos.xyz;
	r4.xyz = normalize(r3.xyz);
	r2.w = dot(r4.xyz, r5.xyz);
	r3.x = -r2.w + 1;
	r2.w = r3.x * -specularParam.z + r2.w;
	r3.x = r1.w * r2.w;
	r3.y = specularParam.y;
	r3 = tex2D(Spec_Pow_sampler, r3);
	r3.xyz = r3.xyz * light_Color.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r0.xyz = r0.www * r0.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = r1.xyz * r0.xyz;
	r0.xyz = r0.xyz * i.color.xxx + r2.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}