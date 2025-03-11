sampler A_Occ_sampler : register(s2);
sampler Color_1_sampler : register(s0);
sampler Color_2_sampler : register(s1);
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
float4 tile : register(c43);

struct PS_IN
{
	float4 color : COLOR;
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
	float4 r4;
	float3 r5;
	float3 r6;
	r0.xy = g_All_Offset.xy;
	r0.xy = i.texcoord.xy * tile.zw + r0.xy;
	r0 = tex2D(Color_2_sampler, r0);
	r1.xy = -r0.yy + r0.xz;
	r2.x = max(abs(r1.x), abs(r1.y));
	r1.x = r2.x + -0.015625;
	r1.y = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.y;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r0.xz = (r1.xx >= 0) ? r0.yy : r0.xz;
	r1 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r2 = tex2D(Color_1_sampler, r1.zwzw);
	r1 = tex2D(A_Occ_sampler, r1);
	r3.xy = -r2.yy + r2.xz;
	r1.w = max(abs(r3.x), abs(r3.y));
	r1.w = r1.w + -0.015625;
	r3.x = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r3.x;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r2.xz = (r1.ww >= 0) ? r2.yy : r2.xz;
	r1.w = r0.w * i.color.w;
	r0.w = r0.w * -i.color.w + 1;
	r3.xyz = lerp(r0.xyz, r2.xyz, r1.www);
	r0.xy = -r1.yy + r1.xz;
	r1.w = max(abs(r0.x), abs(r0.y));
	r0.x = r1.w + -0.015625;
	r0.y = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r0.y;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r1.xz = (r0.xx >= 0) ? r1.yy : r1.xz;
	r0.xyz = r1.xyz * r3.xyz;
	r0.xyz = r0.xyz * ambient_rate.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.x = r1.w + -0.5;
	r3.w = max(r2.x, 0);
	r1.xyz = r1.xyz + r3.www;
	r2.xyz = r1.xyz * r3.xyz;
	r3.w = 1 / i.texcoord7.w;
	r4.xy = r3.ww * i.texcoord7.xy;
	r4.xy = r4.xy * float2(0.5, -0.5) + 0.5;
	r4.xy = r4.xy + g_TargetUvParam.xy;
	r4 = tex2D(Shadow_Tex_sampler, r4);
	r3.w = r4.z + g_ShadowUse.x;
	r4.xyz = r1.www * light_Color.xyz;
	r4.xyz = r4.xyz * r3.www + i.texcoord2.xyz;
	r2.xyz = r2.xyz * r4.xyz;
	r0.xyz = r0.xyz * ambient_rate_rate.xyz + r2.xyz;
	r4 = tex2D(cubemap_sampler, i.texcoord4);
	r4 = r0.w * r4;
	r4 = r4 * ambient_rate_rate.w;
	r2.xyz = r2.www * r4.xyz;
	r0.w = r4.w * CubeParam.y + CubeParam.x;
	r2.xyz = r0.www * r2.xyz;
	r2.xyz = r1.xyz * r2.xyz;
	r4.xyz = r3.xyz * r2.xyz;
	r3.xyz = r3.xyz + specularParam.www;
	r5.xyz = r4.xyz * CubeParam.zzz + r0.xyz;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r4.xyz + r5.xyz;
	r0.w = (-r1.w >= 0) ? 0 : 1;
	r1.w = r1.w * r0.w;
	r4.xyz = r1.www * light_Color.xyz;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r5.xyz = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r6.xyz = normalize(r5.xyz);
	r1.w = dot(r6.xyz, i.texcoord3.xyz);
	r0.w = (-r1.w >= 0) ? 0 : r0.w;
	r4.w = pow(r1.w, specularParam.z);
	r0.w = r0.w * r4.w;
	r4.xyz = r0.www * r4.xyz;
	r4.xyz = r2.www * r4.xyz;
	r4.xyz = r3.www * r4.xyz;
	r1.xyz = r1.xyz * r4.xyz;
	r0.w = abs(specularParam.x);
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r1.xyz * r3.xyz + r0.xyz;
	r1.y = 1;
	r0.w = r1.y + -CubeParam.z;
	r0.xyz = r2.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
