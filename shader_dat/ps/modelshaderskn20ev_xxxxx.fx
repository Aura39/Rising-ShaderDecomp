sampler Color_1_sampler : register(s0);
float4 Incidence_param : register(c45);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float4 g_NormalWeightParam : register(c182);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 g_WeightParam : register(c181);
float4 g_specCalc1 : register(c190);
float4 g_specCalc2 : register(c191);
float hll_rate : register(c44);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
sampler normalmap1_sampler : register(s2);
sampler normalmap2_sampler : register(s3);
float4 point_light1 : register(c63);
float4 point_light2 : register(c65);
float4 point_lightEv0 : register(c184);
float4 point_lightEv1 : register(c186);
float4 point_lightEv2 : register(c188);
float4 point_lightpos1 : register(c64);
float4 point_lightpos2 : register(c66);
float4 point_lightposEv0 : register(c185);
float4 point_lightposEv1 : register(c187);
float4 point_lightposEv2 : register(c189);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 spot_angle : register(c72);
float4 spot_param : register(c73);
float4 tile : register(c46);
sampler tripleMask_sampler : register(s1);
sampler weightmap1_sampler : register(s4);

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
	float4 r5;
	float4 r6;
	float4 r7;
	float3 r8;
	float3 r9;
	float4 r10;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = 1 / spot_angle.w;
	r1.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r0.w = 1 / r0.z;
	r1.xyz = r0.zzz * r1.xyz;
	r0.z = dot(r1.xyz, lightpos.xyz);
	r0.z = r0.z + -spot_param.x;
	r0.y = r0.y * r0.w;
	r0.y = -r0.y + 1;
	r0.y = r0.y * 10;
	r1.xz = float2(2, -1);
	r0.w = r1.z + -spot_param.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r0.z;
	r1.y = max(r0.z, 0);
	r0.z = 1 / spot_param.y;
	r0.z = r0.z * r0.w;
	r0.w = frac(-r1.y);
	r0.w = r0.w + r1.y;
	r1.yw = lerp(i.texcoord.zw, i.texcoord.xy, g_NormalWeightParam.zz);
	r2.xy = r1.yw * tile.xy;
	r1.yw = r1.yw + g_All_Offset.xy;
	r3 = tex2D(Color_1_sampler, r1.ywzw);
	r4 = tex2D(normalmap2_sampler, r2);
	r1.yw = lerp(r4.zw, r4.xy, g_NormalWeightParam.yy);
	r1.yw = r1.yw * 2 + -1;
	r4 = tex2D(weightmap1_sampler, r2);
	r2.z = dot(r4.xyz, g_WeightParam.xyz);
	r2.w = r2.z * g_NormalWeightParam.x;
	r1.z = g_NormalWeightParam.x * r2.z + r1.z;
	r1.z = 1 / r1.z;
	r4 = tex2D(normalmap1_sampler, r2);
	r5 = tex2D(tripleMask_sampler, r2);
	r2.xy = r4.xy * 2 + -1;
	r1.yw = r1.yw * r2.ww + r2.xy;
	r1.yz = r1.zz * r1.yw;
	r2.x = r1.y * i.texcoord2.w;
	r2.y = -r1.z;
	r1.y = dot(r2.y, r2.y) + 0;
	r1.y = -r1.y + 1;
	r1.y = 1 / sqrt(r1.y);
	r1.y = 1 / r1.y;
	r4.xyz = i.texcoord3.xyz;
	r6.xyz = r4.yzx * i.texcoord2.zxy;
	r4.xyz = i.texcoord2.yzx * r4.zxy + -r6.xyz;
	r2.yzw = r2.yyy * r4.xyz;
	r2.xyz = r2.xxx * i.texcoord2.xyz + r2.yzw;
	r1.yzw = r1.yyy * i.texcoord3.xyz + r2.xyz;
	r2.xyz = normalize(r1.yzw);
	r1.y = dot(lightpos.xyz, r2.xyz);
	r1.z = r1.y;
	r0.w = r0.w * r1.z;
	r0.z = r0.z * r0.w;
	r0.y = r0.y * r0.z;
	r2.w = lerp(r0.y, r1.z, spot_param.z);
	r0.y = (-r2.w >= 0) ? 0 : 1;
	r0.z = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r4.xyz = -i.texcoord1.xyz * r0.zzz + lightpos.xyz;
	r6.xyz = r0.zzz * -i.texcoord1.xyz;
	r7.xyz = normalize(r4.xyz);
	r0.z = dot(r7.xyz, r2.xyz);
	r0.w = (-r0.z >= 0) ? 0 : r0.y;
	r0.y = r2.w * r0.y;
	r4.xyz = r0.yyy * light_Color.xyz;
	r1.z = pow(r0.z, specularParam.z);
	r0.y = r0.w * r1.z;
	r0.yzw = r0.yyy * r4.xyz;
	r0.yzw = r5.zzz * r0.yzw;
	r4.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.z = dot(r4.xyz, r4.xyz);
	r1.z = 1 / sqrt(r1.z);
	r7.xyz = r1.zzz * r4.xyz;
	r4.xyz = r4.xyz * r1.zzz + r6.xyz;
	r1.z = 1 / r1.z;
	r1.z = -r1.z + point_lightpos1.w;
	r1.z = r1.z * point_light1.w;
	r8.xyz = normalize(r4.xyz);
	r1.w = dot(r8.xyz, r2.xyz);
	r3.w = dot(r7.xyz, r2.xyz);
	r4.x = (-r3.w >= 0) ? 0 : 1;
	r4.y = (-r1.w >= 0) ? 0 : r4.x;
	r4.x = r3.w * r4.x;
	r4.xzw = r4.xxx * point_light1.xyz;
	r5.y = pow(r1.w, specularParam.z);
	r1.w = r4.y * r5.y;
	r4.xyz = r1.www * r4.xzw;
	r4.xyz = r5.zzz * r4.xyz;
	r4.xyz = r1.zzz * r4.xyz;
	r7 = g_specCalc1;
	r4.xyz = r4.xyz * r7.xxx;
	r0.yzw = r0.yzw * r0.xxx + r4.xyz;
	r4.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r1.w = dot(r4.xyz, r4.xyz);
	r1.w = 1 / sqrt(r1.w);
	r8.xyz = r4.xyz * r1.www + r6.xyz;
	r4.xyz = r1.www * r4.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + point_lightpos2.w;
	r1.w = r1.w * point_light2.w;
	r4.x = dot(r4.xyz, r2.xyz);
	r9.xyz = normalize(r8.xyz);
	r4.y = dot(r9.xyz, r2.xyz);
	r4.z = (-r4.x >= 0) ? 0 : 1;
	r4.w = (-r4.y >= 0) ? 0 : r4.z;
	r5.y = pow(r4.y, specularParam.z);
	r4.y = r4.w * r5.y;
	r4.z = r4.x * r4.z;
	r8.xyz = r4.zzz * point_light2.xyz;
	r4.yzw = r4.yyy * r8.xyz;
	r4.yzw = r5.zzz * r4.yzw;
	r4.yzw = r1.www * r4.yzw;
	r0.yzw = r4.yzw * r7.yyy + r0.yzw;
	r4.yzw = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r5.y = dot(r4.yzw, r4.yzw);
	r5.y = 1 / sqrt(r5.y);
	r8.xyz = r4.yzw * r5.yyy + r6.xyz;
	r4.yzw = r4.yzw * r5.yyy;
	r5.y = 1 / r5.y;
	r5.y = -r5.y + point_lightposEv0.w;
	r5.y = r5.y * point_lightEv0.w;
	r4.y = dot(r4.yzw, r2.xyz);
	r9.xyz = normalize(r8.xyz);
	r4.z = dot(r9.xyz, r2.xyz);
	r4.w = (-r4.y >= 0) ? 0 : 1;
	r6.w = (-r4.z >= 0) ? 0 : r4.w;
	r7.x = pow(r4.z, specularParam.z);
	r4.z = r6.w * r7.x;
	r4.w = r4.y * r4.w;
	r8.xyz = r4.www * point_lightEv0.xyz;
	r8.xyz = r4.zzz * r8.xyz;
	r8.xyz = r5.zzz * r8.xyz;
	r8.xyz = r5.yyy * r8.xyz;
	r0.yzw = r8.xyz * r7.zzz + r0.yzw;
	r7.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r4.z = dot(r7.xyz, r7.xyz);
	r4.z = 1 / sqrt(r4.z);
	r8.xyz = r7.xyz * r4.zzz + r6.xyz;
	r7.xyz = r4.zzz * r7.xyz;
	r4.z = 1 / r4.z;
	r4.z = -r4.z + point_lightposEv1.w;
	r4.z = r4.z * point_lightEv1.w;
	r4.w = dot(r7.xyz, r2.xyz);
	r7.xyz = normalize(r8.xyz);
	r6.w = dot(r7.xyz, r2.xyz);
	r7.x = (-r4.w >= 0) ? 0 : 1;
	r7.y = (-r6.w >= 0) ? 0 : r7.x;
	r7.z = pow(r6.w, specularParam.z);
	r6.w = r7.z * r7.y;
	r7.x = r4.w * r7.x;
	r7.xyz = r7.xxx * point_lightEv1.xyz;
	r7.xyz = r6.www * r7.xyz;
	r7.xyz = r5.zzz * r7.xyz;
	r7.xyz = r4.zzz * r7.xyz;
	r0.yzw = r7.xyz * r7.www + r0.yzw;
	r6.w = g_specCalc2.x;
	r7.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r7.w = dot(r7.xyz, r7.xyz);
	r7.w = 1 / sqrt(r7.w);
	r8.xyz = r7.xyz * r7.www + r6.xyz;
	r7.xyz = r7.www * r7.xyz;
	r7.w = 1 / r7.w;
	r7.w = -r7.w + point_lightposEv2.w;
	r7.w = r7.w * point_lightEv2.w;
	r7.x = dot(r7.xyz, r2.xyz);
	r9.xyz = normalize(r8.xyz);
	r7.y = dot(r9.xyz, r2.xyz);
	r7.z = (-r7.x >= 0) ? 0 : 1;
	r8.x = (-r7.y >= 0) ? 0 : r7.z;
	r8.y = pow(r7.y, specularParam.z);
	r7.y = r8.y * r8.x;
	r7.z = r7.x * r7.z;
	r8.xyz = r7.zzz * point_lightEv2.xyz;
	r8.xyz = r7.yyy * r8.xyz;
	r8.xyz = r5.zzz * r8.xyz;
	r8.xyz = r7.www * r8.xyz;
	r0.yzw = r8.xyz * r6.www + r0.yzw;
	r5.z = r2.w + -0.5;
	r5.z = r5.z + r5.x;
	r0.yzw = r0.yzw * r5.zzz;
	r6.w = abs(specularParam.x);
	r0.yzw = r0.yzw * r6.www;
	r6.w = r4.x * 0.5 + 0.5;
	r6.w = r6.w * r6.w;
	r7.y = lerp(r6.w, r4.x, hll_rate.x);
	r8.xyz = r7.yyy * point_light2.xyz;
	r8.xyz = r1.www * r8.xyz;
	r9.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r1.w = dot(r9.xyz, r9.xyz);
	r1.w = 1 / sqrt(r1.w);
	r9.xyz = r1.www * r9.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + muzzle_lightpos.w;
	r1.w = r1.w * muzzle_light.w;
	r4.x = dot(r9.xyz, r2.xyz);
	r2.x = dot(r2.xyz, r6.xyz);
	r2.y = dot(r6.xyz, lightpos.xyz);
	r2.y = r2.y + 1;
	r2.y = r2.y * Incidence_param.z;
	r2.y = r2.y * 0.5;
	r2.y = -r2.y + 1;
	r2.x = abs(r2.x);
	r2.z = r4.x * 0.5 + 0.5;
	r2.z = r2.z * r2.z;
	r6.x = lerp(r2.z, r4.x, hll_rate.x);
	r6.xyz = r6.xxx * muzzle_light.xyz;
	r2.z = r3.w * 0.5 + 0.5;
	r2.z = r2.z * r2.z;
	r4.x = lerp(r2.z, r3.w, hll_rate.x);
	r9.xyz = r4.xxx * point_light1.xyz;
	r9.xyz = r1.zzz * r9.xyz;
	r10 = r1.x + -g_specCalc1;
	r9.xyz = r9.xyz * r10.xxx;
	r6.xyz = r6.xyz * r1.www + r9.xyz;
	r6.xyz = r8.xyz * r10.yyy + r6.xyz;
	r1.z = r2.w * 0.5 + 0.5;
	r1.z = r1.z * r1.z;
	r3.w = lerp(r1.z, r2.w, hll_rate.x);
	r8.xyz = r3.www * light_Color.xyz;
	r6.xyz = r8.xyz * r0.xxx + r6.xyz;
	r0.x = r4.y * 0.5 + 0.5;
	r0.x = r0.x * r0.x;
	r1.z = lerp(r0.x, r4.y, hll_rate.x);
	r0.x = -r2.x + 1;
	r1.w = r2.x * 0.9 + 0.05;
	r2.x = pow(r0.x, Incidence_param.x);
	r2.zw = -r3.yy + r3.xz;
	r0.x = max(abs(r2.z), abs(r2.w));
	r0.x = r0.x + -0.015625;
	r2.z = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r2.z;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r3.xz = (r0.xx >= 0) ? r3.yy : r3.xz;
	r8.xyz = r1.www * r3.xyz;
	r8.xyz = r8.xyz * Incidence_param.yyy;
	r2.xzw = r2.xxx * r8.xyz;
	r2.xyz = r2.xzw * r2.yyy + r3.xyz;
	r3.xyz = r5.xxx * r3.xyz;
	r3.xyz = r3.xyz * ambient_rate.xyz;
	r3.xyz = r3.xyz * ambient_rate_rate.xyz;
	r8.xyz = r5.zzz * r2.xyz;
	r2.xyz = r2.xyz + specularParam.www;
	r9.xyz = r8.xyz * point_lightEv0.xyz;
	r9.xyz = r1.zzz * r9.xyz;
	r5.xyz = r5.yyy * r9.xyz;
	r5.xyz = r10.zzz * r5.xyz;
	r5.xyz = r8.xyz * r6.xyz + r5.xyz;
	r0.x = r4.w * 0.5 + 0.5;
	r0.x = r0.x * r0.x;
	r1.z = lerp(r0.x, r4.w, hll_rate.x);
	r4.xyw = r8.xyz * point_lightEv1.xyz;
	r6.xyz = r8.xyz * point_lightEv2.xyz;
	r4.xyw = r1.zzz * r4.xyw;
	r4.xyz = r4.zzz * r4.xyw;
	r4.xyz = r4.xyz * r10.www + r5.xyz;
	r0.x = r7.x * 0.5 + 0.5;
	r0.x = r0.x * r0.x;
	r1.z = lerp(r0.x, r7.x, hll_rate.x);
	r5.xyz = r1.zzz * r6.xyz;
	r5.xyz = r7.www * r5.xyz;
	r0.x = r1.x + -g_specCalc2.x;
	r1.xzw = r5.xyz * r0.xxx + r4.xyz;
	r1.xzw = r5.www * r1.xzw;
	r0.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.x = -r0.x + r1.y;
	r0.x = r0.x + 1;
	r1.xyz = r3.xyz * r0.xxx + r1.xzw;
	r0.xyz = r0.yzw * r2.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
