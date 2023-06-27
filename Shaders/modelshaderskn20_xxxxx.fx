sampler Color_1_sampler;
float4 Incidence_param;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float4 g_NormalWeightParam;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 g_WeightParam;
float hll_rate;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
sampler normalmap1_sampler;
sampler normalmap2_sampler;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;
float4 specularParam;
float4 tile;
sampler tripleMask_sampler;
sampler weightmap1_sampler;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
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
	float3 r6;
	r0.xy = lerp(i.texcoord.zw, i.texcoord.xy, g_NormalWeightParam.zz);
	r0.zw = r0.xy * tile.xy;
	r0.xy = r0.xy + g_All_Offset.xy;
	r1 = tex2D(Color_1_sampler, r0);
	r2 = tex2D(normalmap2_sampler, r0.zwzw);
	r0.xy = lerp(r2.zw, r2.xy, g_NormalWeightParam.yy);
	r0.xy = r0.xy * 2 + -1;
	r2 = tex2D(weightmap1_sampler, r0.zwzw);
	r1.w = dot(r2.xyz, g_WeightParam.xyz);
	r2.x = r1.w * g_NormalWeightParam.x;
	r2.z = 1;
	r1.w = g_NormalWeightParam.x * r1.w + r2.z;
	r1.w = 1 / r1.w;
	r3 = tex2D(normalmap1_sampler, r0.zwzw);
	r4 = tex2D(tripleMask_sampler, r0.zwzw);
	r0.zw = r3.xy * 2 + -1;
	r0.xy = r0.xy * r2.xx + r0.zw;
	r0.xy = r1.ww * r0.xy;
	r2.x = r0.x * i.texcoord2.w;
	r2.y = -r0.y;
	r0.x = dot(r2.x, r2.x) + 0;
	r0.x = -r0.x + 1;
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r3.xyz = i.texcoord3.xyz;
	r0.yzw = r3.yzx * i.texcoord2.zxy;
	r0.yzw = i.texcoord2.yzx * r3.zxy + -r0.yzw;
	r0.yzw = r0.yzw * r2.yyy;
	r0.yzw = r2.xxx * i.texcoord2.xyz + r0.yzw;
	r0.xyz = r0.xxx * i.texcoord3.xyz + r0.yzw;
	r2.xyz = normalize(r0.xyz);
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.www * r0.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r0.x = dot(r0.xyz, r2.xyz);
	r0.y = r0.x * 0.5 + 0.5;
	r0.y = r0.y * r0.y;
	r1.w = lerp(r0.y, r0.x, hll_rate.x);
	r0.xyz = r1.www * point_light1.xyz;
	r0.xyz = r0.www * r0.xyz;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r3.xyz, r3.xyz);
	r0.w = 1 / sqrt(r0.w);
	r3.xyz = r0.www * r3.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r1.w = dot(r3.xyz, r2.xyz);
	r2.w = r1.w * 0.5 + 0.5;
	r2.w = r2.w * r2.w;
	r3.x = lerp(r2.w, r1.w, hll_rate.x);
	r3.xyz = r3.xxx * muzzle_light.xyz;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xy = r0.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(Shadow_Tex_sampler, r3);
	r0.w = r3.z + g_ShadowUse.x;
	r1.w = dot(lightpos.xyz, r2.xyz);
	r2.w = r1.w;
	r3.x = r2.w * 0.5 + 0.5;
	r3.x = r3.x * r3.x;
	r4.y = lerp(r3.x, r2.w, hll_rate.x);
	r3.xyz = r4.yyy * light_Color.xyz;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r3.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r3.x = 1 / sqrt(r3.x);
	r3.yzw = r3.xxx * -i.texcoord1.xyz;
	r5.xyz = -i.texcoord1.xyz * r3.xxx + lightpos.xyz;
	r6.xyz = normalize(r5.xyz);
	r3.x = dot(r6.xyz, r2.xyz);
	r2.x = dot(r2.xyz, r3.yzw);
	r2.y = dot(r3.yzw, lightpos.xyz);
	r2.y = r2.y + 1;
	r2.y = r2.y * Incidence_param.z;
	r2.y = r2.y * 0.5;
	r2.x = abs(r2.x);
	r2.z = r2.x * 0.9 + 0.05;
	r2.xy = -r2.xy + 1;
	r3.y = pow(r2.x, Incidence_param.x);
	r3.zw = -r1.yy + r1.xz;
	r2.x = max(abs(r3.z), abs(r3.w));
	r2.x = r2.x + -0.015625;
	r3.z = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r3.z;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r1.xz = (r2.xx >= 0) ? r1.yy : r1.xz;
	r5.xyz = r1.xyz * r2.zzz;
	r5.xyz = r5.xyz * Incidence_param.yyy;
	r3.yzw = r3.yyy * r5.xyz;
	r2.xyz = r3.yzw * r2.yyy + r1.xyz;
	r1.xyz = r4.xxx * r1.xyz;
	r1.xyz = r1.xyz * ambient_rate.xyz;
	r1.xyz = r1.xyz * ambient_rate_rate.xyz;
	r3.y = r2.w + -0.5;
	r4.y = max(r3.y, 0);
	r3.y = r4.y + r4.x;
	r5.xyz = r2.xyz * r3.yyy;
	r2.xyz = r2.xyz + specularParam.www;
	r0.xyz = r0.xyz * r5.xyz;
	r0.xyz = r4.www * r0.xyz;
	r3.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = r1.w + -r3.z;
	r1.w = r1.w + 1;
	r0.xyz = r1.xyz * r1.www + r0.xyz;
	r1.x = pow(r3.x, specularParam.z);
	r1.y = (-r2.w >= 0) ? 0 : 1;
	r1.z = r2.w * r1.y;
	r1.y = (-r3.x >= 0) ? 0 : r1.y;
	r1.x = r1.x * r1.y;
	r1.yzw = r1.zzz * light_Color.xyz;
	r1.xyz = r1.xxx * r1.yzw;
	r1.xyz = r4.zzz * r1.xyz;
	r1.xyz = r0.www * r1.xyz;
	r1.xyz = r3.yyy * r1.xyz;
	r0.w = abs(specularParam.x);
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r1.xyz * r2.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}