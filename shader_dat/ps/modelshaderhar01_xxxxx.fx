sampler Color_1_sampler : register(s0);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float aniso_diff_rate : register(c49);
float aniso_shine : register(c50);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float hll_rate : register(c43);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
sampler normalmap_sampler : register(s1);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
sampler specularmap_sampler : register(s2);
float ss_scat_pow : register(c46);
float ss_scat_rate : register(c44);
float4 tile : register(c51);

struct PS_IN
{
	float4 color : COLOR;
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
	float4 r5;
	float4 r6;
	float3 r7;
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
	r2.w = dot(r4.xyz, r4.xyz);
	r2.w = 1 / sqrt(r2.w);
	r4.xyw = r2.www * r4.xyz;
	r2.w = r4.z * -r2.w + 1;
	r2.x = dot(r2.xyz, r4.xyw);
	r2.y = r2.x * 0.5 + 0.5;
	r2.y = r2.y * r2.y;
	r3.w = lerp(r2.y, r2.x, hll_rate.x);
	r2.xyz = r3.www * point_light1.xyz;
	r2.xyz = r0.www * r2.xyz;
	r5.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r5.xyz, r5.xyz);
	r0.w = 1 / sqrt(r0.w);
	r5.xyz = r0.www * r5.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r3.w = dot(r5.xyz, r4.xyw);
	r4.z = r3.w * 0.5 + 0.5;
	r4.z = r4.z * r4.z;
	r5.x = lerp(r4.z, r3.w, hll_rate.x);
	r5.xyz = r5.xxx * muzzle_light.xyz;
	r2.xyz = r5.xyz * r0.www + r2.xyz;
	r5.y = dot(i.texcoord1.xyz, -r4.xyw);
	r0.w = 1 / i.texcoord7.w;
	r5.zw = r0.ww * i.texcoord7.xy;
	r5.zw = r5.zw * float2(-0.5, 0.5) + 0.5;
	r5.zw = r5.zw + g_TargetUvParam.xy;
	r6 = tex2D(Shadow_Tex_sampler, r5.zwzw);
	r0.w = r6.z + g_ShadowUse.x;
	r3.w = dot(lightpos.xyz, r4.xyw);
	r5.x = r3.w;
	r5.yz = r0.ww * r5.xy;
	r5.yz = r5.yz * -0.5 + 1;
	r6.xy = r5.yz * r5.yz;
	r6.xy = r6.xy * r6.xy;
	r5.yz = r5.yz * -r6.xy + 1;
	r4.z = r5.z * r5.y;
	r5.y = r4.z * 0.193754 + 0.5;
	r4.z = r4.z * 0.387508;
	r5.y = r5.y * r5.y + -r4.z;
	r4.z = hll_rate.x * r5.y + r4.z;
	r6.xyz = light_Color.xyz;
	r5.yzw = r6.xyz * aniso_diff_rate.xxx;
	r2.xyz = r5.yzw * r4.zzz + r2.xyz;
	r5.yz = -r1.yy + r1.xz;
	r4.z = max(abs(r5.y), abs(r5.z));
	r4.z = r4.z + -0.015625;
	r5.y = (-r4.z >= 0) ? 0 : 1;
	r4.z = (r4.z >= 0) ? -0 : -1;
	r4.z = r4.z + r5.y;
	r4.z = (r4.z >= 0) ? -r4.z : -0;
	r1.xz = (r4.zz >= 0) ? r1.yy : r1.xz;
	r6.w = r1.w * ambient_rate.w;
	r2.xyz = r2.xyz * r1.xyz;
	r5.yzw = r1.xyz * ambient_rate.xyz;
	r5.yzw = r5.yzw * ambient_rate_rate.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = -r1.w + r3.w;
	r1.w = r1.w + 1;
	r2.xyz = r5.yzw * r1.www + r2.xyz;
	r5.yzw = lightpos.xyz + -i.texcoord1.xyz;
	r7.xyz = normalize(r5.yzw);
	r1.w = dot(r7.xyz, r3.xyz);
	r3.y = 1;
	r1.w = abs(r1.w) * -aniso_shine.x + r3.y;
	r3.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r3.x = 1 / sqrt(r3.x);
	r3.xzw = -i.texcoord1.xyz * r3.xxx + lightpos.xyz;
	r7.xyz = normalize(r3.xzw);
	r3.x = dot(r7.xyz, r4.xyw);
	r1.w = r1.w * r3.x;
	r3.x = pow(r1.w, specularParam.z);
	r3.z = (-r5.x >= 0) ? 0 : 1;
	r3.w = r5.x * r3.z;
	r1.w = (-r1.w >= 0) ? 0 : r3.z;
	r1.w = r3.x * r1.w;
	r3.xzw = r3.www * light_Color.xyz;
	r3.xzw = r1.www * r3.xzw;
	r0.xyz = r0.xyz * r3.xzw;
	r0.xyz = r0.www * r0.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r3.xzw = r1.xyz + specularParam.www;
	r1.xyz = r2.www * r1.xyz;
	r0.w = r2.w + -ss_scat_rate.x;
	r1.xyz = r1.xyz * ss_scat_pow.xxx;
	r0.xyz = r0.xyz * r3.xzw;
	r6.xyz = r0.xyz * i.color.xxx + r2.xyz;
	r2 = r6 * i.color;
	r0.x = r3.y + -ss_scat_rate.x;
	r0.x = 1 / r0.x;
	r0.x = r0.x * r0.w;
	r0.w = r0.w;
	r0.y = frac(-r0.w);
	r0.y = r0.y + r0.w;
	r0.x = r0.y * r0.x;
	r0.xyz = r1.xyz * r0.xxx + r2.xyz;
	r0.w = r2.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
