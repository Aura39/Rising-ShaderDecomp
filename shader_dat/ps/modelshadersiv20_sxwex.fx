sampler A_Occ_sampler : register(s2);
sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap_sampler : register(s3);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
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
	float3 r7;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.xyz = r0.yyy * light_Color.xyz;
	r1.xyz = r1.xyz * r0.xxx + i.texcoord2.xyz;
	r2 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r3 = tex2D(A_Occ_sampler, r2);
	r2 = tex2D(Color_1_sampler, r2.zwzw);
	r0.zw = -r3.yy + r3.xz;
	r1.w = max(abs(r0.z), abs(r0.w));
	r0.z = r1.w + -0.015625;
	r0.w = (-r0.z >= 0) ? 0 : 1;
	r0.z = (r0.z >= 0) ? -0 : -1;
	r0.z = r0.z + r0.w;
	r0.z = (r0.z >= 0) ? -r0.z : -0;
	r3.xz = (r0.zz >= 0) ? r3.yy : r3.xz;
	r0.z = r0.y + -0.5;
	r1.w = max(r0.z, 0);
	r4.xyz = r1.www + r3.xyz;
	r0.zw = -r2.yy + r2.xz;
	r1.w = max(abs(r0.z), abs(r0.w));
	r0.z = r1.w + -0.015625;
	r0.w = (-r0.z >= 0) ? 0 : 1;
	r0.z = (r0.z >= 0) ? -0 : -1;
	r0.z = r0.z + r0.w;
	r0.z = (r0.z >= 0) ? -r0.z : -0;
	r2.xz = (r0.zz >= 0) ? r2.yy : r2.xz;
	r5.xyz = r4.xyz * r2.xyz;
	r1.xyz = r1.xyz * r5.xyz;
	r3.xyz = r3.xyz * r2.xyz;
	r3.xyz = r3.xyz * ambient_rate.xyz;
	r1.xyz = r3.xyz * ambient_rate_rate.xyz + r1.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3 = r3 * ambient_rate_rate.w;
	r3.xyz = r2.www * r3.xyz;
	r0.z = r3.w * CubeParam.y + CubeParam.x;
	r3.xyz = r0.zzz * r3.xyz;
	r3.xyz = r4.xyz * r3.xyz;
	r5.xyz = r2.xyz * r3.xyz;
	r2.xyz = r2.xyz + specularParam.www;
	r6.xyz = r5.xyz * CubeParam.zzz + r1.xyz;
	r5.xyz = r5.xyz * CubeParam.zzz;
	r1.xyz = r1.xyz * -r5.xyz + r6.xyz;
	r0.z = (-r0.y >= 0) ? 0 : 1;
	r0.y = r0.y * r0.z;
	r5.xyz = r0.yyy * light_Color.xyz;
	r0.y = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.y = 1 / sqrt(r0.y);
	r6.xyz = -i.texcoord1.xyz * r0.yyy + lightpos.xyz;
	r7.xyz = normalize(r6.xyz);
	r0.y = dot(r7.xyz, i.texcoord3.xyz);
	r0.z = (-r0.y >= 0) ? 0 : r0.z;
	r1.w = pow(r0.y, specularParam.z);
	r0.y = r0.z * r1.w;
	r0.yzw = r0.yyy * r5.xyz;
	r0.yzw = r2.www * r0.yzw;
	r0.xyz = r0.xxx * r0.yzw;
	r0.xyz = r4.xyz * r0.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = r0.xyz * r2.xyz + r1.xyz;
	r1.y = 1;
	r0.w = r1.y + -CubeParam.z;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
