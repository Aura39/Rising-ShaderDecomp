sampler Color_1_sampler : register(s0);
float4 Incidence_param : register(c44);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 g_specCalc1 : register(c190);
float4 g_specCalc2 : register(c191);
float hll_rate : register(c43);
sampler incidence_sampler : register(s3);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
sampler normalmap_sampler : register(s2);
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
float4 tile : register(c45);
sampler tripleMask_sampler : register(s1);

struct PS_IN
{
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
	float4 r7;
	float4 r8;
	float4 r9;
	float3 r10;
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
	r1.y = 1;
	r0.w = r1.y + -spot_param.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r0.z;
	r1.x = max(r0.z, 0);
	r0.z = 1 / spot_param.y;
	r0.z = r0.z * r0.w;
	r0.w = frac(-r1.x);
	r0.w = r0.w + r1.x;
	r1.xyz = i.texcoord3.xyz;
	r2.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r2.xyz;
	r2.xy = tile.xy;
	r2.xy = i.texcoord.xy * r2.xy + g_All_Offset.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xyz = r1.xyz * -r2.yyy;
	r1.w = r2.x * i.texcoord2.w;
	r1.xyz = r1.www * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r2.zzz * i.texcoord3.xyz + r1.xyz;
	r2.xyz = normalize(r1.xyz);
	r1.x = dot(lightpos.xyz, r2.xyz);
	r1.y = r1.x;
	r0.w = r0.w * r1.y;
	r0.z = r0.z * r0.w;
	r0.y = r0.y * r0.z;
	r2.w = lerp(r0.y, r1.y, spot_param.z);
	r0.y = (-r2.w >= 0) ? 0 : 1;
	r0.z = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r1.yzw = -i.texcoord1.xyz * r0.zzz + lightpos.xyz;
	r3.xyz = r0.zzz * -i.texcoord1.xyz;
	r4.xyz = normalize(r1.yzw);
	r0.z = dot(r4.xyz, r2.xyz);
	r0.w = (-r0.z >= 0) ? 0 : r0.y;
	r0.y = r2.w * r0.y;
	r1.yzw = r0.yyy * light_Color.xyz;
	r3.w = pow(r0.z, specularParam.z);
	r0.y = r0.w * r3.w;
	r0.yzw = r0.yyy * r1.yzw;
	r1.yz = tile.xy * i.texcoord.xy;
	r4 = tex2D(tripleMask_sampler, r1.yzzw);
	r0.yzw = r0.yzw * r4.zzz;
	r1.yzw = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.w = dot(r1.yzw, r1.yzw);
	r3.w = 1 / sqrt(r3.w);
	r5.xyz = r1.yzw * r3.www + r3.xyz;
	r1.yzw = r1.yzw * r3.www;
	r3.w = 1 / r3.w;
	r3.w = -r3.w + point_lightpos1.w;
	r3.w = r3.w * point_light1.w;
	r1.y = dot(r1.yzw, r2.xyz);
	r6.xyz = normalize(r5.xyz);
	r1.z = dot(r6.xyz, r2.xyz);
	r1.w = (-r1.y >= 0) ? 0 : 1;
	r4.y = (-r1.z >= 0) ? 0 : r1.w;
	r5.x = pow(r1.z, specularParam.z);
	r1.z = r4.y * r5.x;
	r1.w = r1.y * r1.w;
	r5.xyz = r1.www * point_light1.xyz;
	r5.xyz = r1.zzz * r5.xyz;
	r5.xyz = r4.zzz * r5.xyz;
	r5.xyz = r3.www * r5.xyz;
	r6 = g_specCalc1;
	r5.xyz = r5.xyz * r6.xxx;
	r0.yzw = r0.yzw * r0.xxx + r5.xyz;
	r5.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r1.z = dot(r5.xyz, r5.xyz);
	r1.z = 1 / sqrt(r1.z);
	r7.xyz = r5.xyz * r1.zzz + r3.xyz;
	r5.xyz = r1.zzz * r5.xyz;
	r1.z = 1 / r1.z;
	r1.z = -r1.z + point_lightpos2.w;
	r1.z = r1.z * point_light2.w;
	r1.w = dot(r5.xyz, r2.xyz);
	r5.xyz = normalize(r7.xyz);
	r4.y = dot(r5.xyz, r2.xyz);
	r5.x = (-r1.w >= 0) ? 0 : 1;
	r5.y = (-r4.y >= 0) ? 0 : r5.x;
	r5.z = pow(r4.y, specularParam.z);
	r4.y = r5.z * r5.y;
	r5.x = r1.w * r5.x;
	r5.xyz = r5.xxx * point_light2.xyz;
	r5.xyz = r4.yyy * r5.xyz;
	r5.xyz = r4.zzz * r5.xyz;
	r5.xyz = r1.zzz * r5.xyz;
	r0.yzw = r5.xyz * r6.yyy + r0.yzw;
	r5.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r4.y = dot(r5.xyz, r5.xyz);
	r4.y = 1 / sqrt(r4.y);
	r7.xyz = r5.xyz * r4.yyy + r3.xyz;
	r5.xyz = r4.yyy * r5.xyz;
	r4.y = 1 / r4.y;
	r4.y = -r4.y + point_lightposEv0.w;
	r4.y = r4.y * point_lightEv0.w;
	r5.x = dot(r5.xyz, r2.xyz);
	r8.xyz = normalize(r7.xyz);
	r5.y = dot(r8.xyz, r2.xyz);
	r5.z = (-r5.x >= 0) ? 0 : 1;
	r5.w = (-r5.y >= 0) ? 0 : r5.z;
	r6.x = pow(r5.y, specularParam.z);
	r5.y = r5.w * r6.x;
	r5.z = r5.x * r5.z;
	r7.xyz = r5.zzz * point_lightEv0.xyz;
	r5.yzw = r5.yyy * r7.xyz;
	r5.yzw = r4.zzz * r5.yzw;
	r5.yzw = r4.yyy * r5.yzw;
	r0.yzw = r5.yzw * r6.zzz + r0.yzw;
	r5.yzw = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r6.x = dot(r5.yzw, r5.yzw);
	r6.x = 1 / sqrt(r6.x);
	r7.xyz = r5.yzw * r6.xxx + r3.xyz;
	r5.yzw = r5.yzw * r6.xxx;
	r6.x = 1 / r6.x;
	r6.x = -r6.x + point_lightposEv1.w;
	r6.x = r6.x * point_lightEv1.w;
	r5.y = dot(r5.yzw, r2.xyz);
	r8.xyz = normalize(r7.xyz);
	r5.z = dot(r8.xyz, r2.xyz);
	r5.w = (-r5.y >= 0) ? 0 : 1;
	r6.y = (-r5.z >= 0) ? 0 : r5.w;
	r6.z = pow(r5.z, specularParam.z);
	r5.z = r6.z * r6.y;
	r5.w = r5.y * r5.w;
	r7.xyz = r5.www * point_lightEv1.xyz;
	r7.xyz = r5.zzz * r7.xyz;
	r7.xyz = r4.zzz * r7.xyz;
	r7.xyz = r6.xxx * r7.xyz;
	r0.yzw = r7.xyz * r6.www + r0.yzw;
	r5.z = g_specCalc2.x;
	r6.yzw = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r5.w = dot(r6.yzw, r6.yzw);
	r5.w = 1 / sqrt(r5.w);
	r7.xyz = r6.yzw * r5.www + r3.xyz;
	r6.yzw = r5.www * r6.yzw;
	r5.w = 1 / r5.w;
	r5.w = -r5.w + point_lightposEv2.w;
	r5.w = r5.w * point_lightEv2.w;
	r6.y = dot(r6.yzw, r2.xyz);
	r8.xyz = normalize(r7.xyz);
	r6.z = dot(r8.xyz, r2.xyz);
	r6.w = (-r6.y >= 0) ? 0 : 1;
	r7.x = (-r6.z >= 0) ? 0 : r6.w;
	r7.y = pow(r6.z, specularParam.z);
	r6.z = r7.y * r7.x;
	r6.w = r6.y * r6.w;
	r7.xyz = r6.www * point_lightEv2.xyz;
	r7.xyz = r6.zzz * r7.xyz;
	r7.xyz = r4.zzz * r7.xyz;
	r7.xyz = r5.www * r7.xyz;
	r0.yzw = r7.xyz * r5.zzz + r0.yzw;
	r4.z = r2.w + -0.5;
	r4.z = r4.z + r4.x;
	r0.yzw = r0.yzw * r4.zzz;
	r5.z = abs(specularParam.x);
	r0.yzw = r0.yzw * r5.zzz;
	r5.z = r1.w * 0.5 + 0.5;
	r5.z = r5.z * r5.z;
	r6.z = lerp(r5.z, r1.w, hll_rate.x);
	r7.xyz = r6.zzz * point_light2.xyz;
	r7.xyz = r1.zzz * r7.xyz;
	r8.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r1.z = dot(r8.xyz, r8.xyz);
	r1.z = 1 / sqrt(r1.z);
	r8.xyz = r1.zzz * r8.xyz;
	r1.z = 1 / r1.z;
	r1.z = -r1.z + muzzle_lightpos.w;
	r1.z = r1.z * muzzle_light.w;
	r1.w = dot(r8.xyz, r2.xyz);
	r2.x = dot(r2.xyz, r3.xyz);
	r2.y = dot(r3.xyz, lightpos.xyz);
	r2.y = r2.y + 1;
	r2.y = r2.y * Incidence_param.z;
	r2.y = r2.y * 0.5;
	r2.x = abs(r2.x);
	r2.z = r1.w * 0.5 + 0.5;
	r2.z = r2.z * r2.z;
	r3.x = lerp(r2.z, r1.w, hll_rate.x);
	r3.xyz = r3.xxx * muzzle_light.xyz;
	r1.w = r1.y * 0.5 + 0.5;
	r1.w = r1.w * r1.w;
	r2.z = lerp(r1.w, r1.y, hll_rate.x);
	r8.xyz = r2.zzz * point_light1.xyz;
	r8.xyz = r3.www * r8.xyz;
	r2.z = 2;
	r9 = r2.z + -g_specCalc1;
	r8.xyz = r8.xyz * r9.xxx;
	r1.yzw = r3.xyz * r1.zzz + r8.xyz;
	r1.yzw = r7.xyz * r9.yyy + r1.yzw;
	r3.x = r2.w * 0.5 + 0.5;
	r3.x = r3.x * r3.x;
	r5.z = lerp(r3.x, r2.w, hll_rate.x);
	r3.xyz = r5.zzz * light_Color.xyz;
	r1.yzw = r3.xyz * r0.xxx + r1.yzw;
	r0.x = r5.x * 0.5 + 0.5;
	r0.x = r0.x * r0.x;
	r2.w = lerp(r0.x, r5.x, hll_rate.x);
	r0.x = -r2.x + 1;
	r2.x = r2.x * 0.9 + 0.05;
	r3.x = pow(r0.x, Incidence_param.x);
	r7 = tex2D(incidence_sampler, i.texcoord);
	r3.yzw = r2.xxx * r7.xyz;
	r3.yzw = r3.yzw * Incidence_param.yyy;
	r3.xyz = r3.xxx * r3.yzw;
	r0.x = -r2.y + 1;
	r5.xz = g_All_Offset.xy + i.texcoord.xy;
	r8 = tex2D(Color_1_sampler, r5.xzzw);
	r5.xz = -r8.yy + r8.xz;
	r2.x = max(abs(r5.x), abs(r5.z));
	r2.x = r2.x + -0.015625;
	r3.w = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r3.w;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r8.xz = (r2.xx >= 0) ? r8.yy : r8.xz;
	r10.xyz = lerp(r8.xyz, r7.xyz, r2.yyy);
	r3.xyz = r3.xyz * r0.xxx + r10.xyz;
	r7.xyz = r4.xxx * r10.xyz;
	r7.xyz = r7.xyz * ambient_rate.xyz;
	r7.xyz = r7.xyz * ambient_rate_rate.xyz;
	r8.xyz = r4.zzz * r3.xyz;
	r3.xyz = r3.xyz + specularParam.www;
	r10.xyz = r8.xyz * point_lightEv0.xyz;
	r2.xyw = r2.www * r10.xyz;
	r2.xyw = r4.yyy * r2.xyw;
	r2.xyw = r9.zzz * r2.xyw;
	r1.yzw = r8.xyz * r1.yzw + r2.xyw;
	r0.x = r5.y * 0.5 + 0.5;
	r0.x = r0.x * r0.x;
	r2.x = lerp(r0.x, r5.y, hll_rate.x);
	r4.xyz = r8.xyz * point_lightEv1.xyz;
	r5.xyz = r8.xyz * point_lightEv2.xyz;
	r2.xyw = r2.xxx * r4.xyz;
	r2.xyw = r6.xxx * r2.xyw;
	r1.yzw = r2.xyw * r9.www + r1.yzw;
	r0.x = r6.y * 0.5 + 0.5;
	r0.x = r0.x * r0.x;
	r2.x = lerp(r0.x, r6.y, hll_rate.x);
	r2.xyw = r2.xxx * r5.xyz;
	r2.xyw = r5.www * r2.xyw;
	r0.x = r2.z + -g_specCalc2.x;
	r1.yzw = r2.xyw * r0.xxx + r1.yzw;
	r1.yzw = r4.www * r1.yzw;
	r0.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.x = -r0.x + r1.x;
	r0.x = r0.x + 1;
	r1.xyz = r7.xyz * r0.xxx + r1.yzw;
	r0.xyz = r0.yzw * r3.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
