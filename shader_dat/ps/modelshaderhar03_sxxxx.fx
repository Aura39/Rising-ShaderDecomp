sampler Color_1_sampler : register(s0);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float aniso_diff_rate : register(c44);
float aniso_shine : register(c45);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float4 g_BackLightRate : register(c181);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float hll_rate : register(c43);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
sampler specularmap_sampler : register(s2);

struct PS_IN
{
	float3 color : COLOR;
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
	r2.x = dot(r2.xyz, i.texcoord3.xyz);
	r2.y = r2.x;
	r2.x = -r2.x;
	r2.z = r2.y * 0.5 + 0.5;
	r2.z = r2.z * r2.z;
	r3.x = lerp(r2.z, r2.y, hll_rate.x);
	r2.yzw = r3.xxx * point_light1.xyz;
	r2.yzw = r0.www * r2.yzw;
	r0.w = r2.x * 0.5 + 0.5;
	r0.w = r0.w * r0.w + -r2.x;
	r0.w = hll_rate.x * r0.w + r2.x;
	r3.xyz = r0.www * point_light1.xyz;
	r3.xyz = r3.xyz * i.color.yyy;
	r3.xyz = r3.xyz * g_BackLightRate.xxx;
	r2.xyz = r2.yzw * i.color.zzz + r3.xyz;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r3.xyz, r3.xyz);
	r0.w = 1 / sqrt(r0.w);
	r3.xyz = r0.www * r3.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r2.w = dot(r3.xyz, i.texcoord3.xyz);
	r3.x = r2.w * 0.5 + 0.5;
	r3.x = r3.x * r3.x;
	r4.x = lerp(r3.x, r2.w, hll_rate.x);
	r3.xyz = r4.xxx * muzzle_light.xyz;
	r2.xyz = r3.xyz * r0.www + r2.xyz;
	r3.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = -r3.y;
	r2.w = r0.w * 0.5 + 0.5;
	r2.w = r2.w * r2.w;
	r3.x = lerp(r2.w, r0.w, hll_rate.x);
	r4.xyz = i.texcoord1.xyz;
	r3.z = dot(r4.xyz, -i.texcoord3.xyz);
	r3.xyw = r3.xyz;
	r3.xw = r3.xw * -0.5 + 1;
	r4.xy = r3.xw * r3.xw;
	r4.xy = r4.xy * r4.xy;
	r3.xw = r3.xw * -r4.xy + 1;
	r0.w = r3.w * r3.x;
	r0.w = r0.w * 0.387508;
	r4.xyz = light_Color.xyz;
	r4.xyz = r4.xyz * aniso_diff_rate.xxx;
	r5.xyz = r0.www * r4.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xw = r0.ww * i.texcoord7.xy;
	r3.xw = r3.xw * float2(0.5, -0.5) + 0.5;
	r3.xw = r3.xw + g_TargetUvParam.xy;
	r6 = tex2D(Shadow_Tex_sampler, r3.xwzw);
	r0.w = r6.z + g_ShadowUse.x;
	r3.xz = r0.ww * r3.yz;
	r3.xz = r3.xz * -0.5 + 1;
	r6.xy = r3.xz * r3.xz;
	r6.xy = r6.xy * r6.xy;
	r3.xz = r3.xz * -r6.xy + 1;
	r2.w = r3.z * r3.x;
	r3.x = r2.w * 0.193754 + 0.5;
	r2.w = r2.w * 0.387508;
	r3.x = r3.x * r3.x + -r2.w;
	r2.w = hll_rate.x * r3.x + r2.w;
	r3.xzw = r2.www * r4.xyz;
	r3.xzw = r3.xzw * i.color.zzz + r5.xyz;
	r2.xyz = r2.xyz + r3.xzw;
	r3.xz = -r1.yy + r1.xz;
	r2.w = max(abs(r3.x), abs(r3.z));
	r2.w = r2.w + -0.015625;
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.w = (r2.w >= 0) ? -r2.w : -0;
	r1.xz = (r2.ww >= 0) ? r1.yy : r1.xz;
	r1.w = r1.w * ambient_rate.w;
	r1.w = r1.w * prefogcolor_enhance.w;
	o.w = r1.w;
	r2.xyz = r2.xyz * r1.xyz;
	r3.xzw = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r2.xyz = r3.xzw * ambient_rate_rate.xyz + r2.xyz;
	r1.w = (-r3.y >= 0) ? 0 : 1;
	r2.w = r3.y * r1.w;
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

	return o;
}
